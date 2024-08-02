import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import * as bcryptjs from 'bcryptjs';
import { JwtService } from '@nestjs/jwt'

@Injectable()
export class AuthService {
  
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService
  ){}

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

    const email = user.email

    const payload = { email: email }
    const token = await this.jwtService.signAsync(payload)

    return {
      token,
      email
    }

  }

}

