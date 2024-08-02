import { Column, Entity, OneToMany } from 'typeorm';
import { User } from './user.entity';

@Entity()
export class Rol {

    @Column({ primary: true, generated: true })
    id: number;

    @Column({ length: 20 })
    name: string;

    @OneToMany(() => User, user => user.rol)
    users: User;
}