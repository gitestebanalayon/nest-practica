import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './users/users.module';
import { CustomersModule } from './customers/customers.module';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: 'postgres',
      database: 'global_prueba',
      autoLoadEntities: true,
      synchronize: true,
    }),
    UsersModule,
    CustomersModule,
    AuthModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }