import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import * as bcryptjs from 'bcryptjs'

@Injectable()
export class AuthService {
  
  constructor( private readonly usersService: UsersService ){}

  async register(registerDto: RegisterDto){
    return await this.usersService.create(registerDto)
  }

  async login(loginDto: LoginDto){
    const user = await this.usersService.findOneByEmail(loginDto.email)

    if (!user) {
      throw new UnauthorizedException('Correo incorrecto');
    }

    const isPasswordValid = await bcryptjs.compare(loginDto.password, user.password)

    if (!isPasswordValid) {
      throw new UnauthorizedException('Contraseña incorrecta');
    }

    return user

  }

}

