import { Injectable, ConflictException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { RemoveUserDto } from './dto/remove-user.dto';
import { User } from './entities/user.entity';
import { Rol } from './entities/rol.entity';
import * as bcryptjs from 'bcryptjs'

@Injectable()
export class UsersService {

    constructor(
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
        @InjectRepository(Rol)
        private readonly rolRepository: Repository<Rol>
    ) { }

    async create(createUserDto: CreateUserDto) {
        try {
            const userCount = await this.userRepository.count();
            if (userCount === 0) {
                createUserDto.is_superuser = true;
                createUserDto.is_staff = true;
                createUserDto.is_active = true;
                createUserDto.rolId = null;
            } else {
                createUserDto.is_superuser = false;
                createUserDto.is_staff = false;
                createUserDto.is_active = false;
                // Obtiene el rol de Usuario por defecto
                const userRole = await this.rolRepository.findOne({ where: { name: 'Usuario' } });
                if (!userRole) {
                    throw new Error('El rol por defecto "Usuario" no funciona');
                }
                createUserDto.rolId = userRole.id;
            }

            const salt = await bcryptjs.genSalt();
            createUserDto.password = await bcryptjs.hash(createUserDto.password, salt);

            return await this.userRepository.save(createUserDto);
        } catch (error) {
            if (error.code === '23505') { // Código de error para duplicados en PostgreSQL
                throw new ConflictException('Username, email, or identify already exists');
            }
            throw error;
        }
    }

    async findOneByEmail(email: string) {
        return this.userRepository.findOneBy({email})
    }

    async findAll() {
        return await this.userRepository.find();
    }

    async findOne(id: number) {
        const userExist = await this.userRepository.findOneBy({ id })
        if (userExist !== null) {
            return await this.userRepository.findOneBy({ id })
        } else {
            return { "message": "El usuario no existe" }
        }
    }

    async update(id: number, updateUserDto: UpdateUserDto) {
        try {
            const verifyUpdate = await this.userRepository.update(id, updateUserDto)
            if (verifyUpdate.affected >= 1) {
                return { "message": "El usuario se actualizó exitosamente" }
            } else {
                return { "message": "Error al actualizar el usuario" }
            }
        } catch (error) {
            return { "message": "Hubo un error en el servidor" }
        }
    }

    async isActive(id: number, removeUserDto: RemoveUserDto) {
        try {

            removeUserDto.is_active = false

            const verifyRemove = await this.userRepository.update(id, removeUserDto)

            if (verifyRemove.affected >= 1) {
                return { "message": "Usuario desactivado" }
            } else {
                return { "message": "Error al desactivar el usuario" }
            }
        } catch (error) {
            return { "message": "Hubo un error en el servidor" }
        }
    }

}
