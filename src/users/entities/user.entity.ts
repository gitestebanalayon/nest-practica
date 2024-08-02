import { Column, Entity, CreateDateColumn, UpdateDateColumn, ManyToOne } from 'typeorm';
import { Rol } from './rol.entity';

@Entity()
export class User {

    @Column({ primary: true, generated: true })
    id: number;

    @Column({ length: 20, unique: true })
    username: string;

    @Column({ unique: true })
    email: string;

    @Column({ length: 1 })
    nationality: string;

    @Column({ unique: true })
    identify: number;

    @Column()
    password: string;

    @Column()
    name_lastname: string;

    @CreateDateColumn({ type: 'timestamp' }) // Guarda la fecha de creación de usuario
    created_date: Date;

    @UpdateDateColumn({ type: 'timestamp', nullable: true }) // Guarda la fecha de la ultima vez que se actualizo el registro.
    updated_date: Date;

    @Column({ type: 'timestamp', nullable: true }) // Guarda la fecha de la ultima vez que se logueó
    last_login: Date | null;

    @Column({ default: false }) // Para que el usuario no pueda loguearse.
    is_staff: boolean;

    @Column({ default: true }) // Al eliminar se establece a false.
    is_active: boolean;

    @Column({ default: false }) // Establece si el usuario es super usuario
    is_superuser: boolean;

    @ManyToOne(() => Rol, rol => rol.users, { nullable: true })
    rol: Rol;

    @Column({ nullable: true })
    rolId: number;
    
}


