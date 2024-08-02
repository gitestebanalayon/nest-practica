export class CreateUserDto {
    username: string;
    email: string;
    nationality: string;
    identify: number;
    password: string;
    name_lastname: string;
    is_staff?: boolean;
    is_active?: boolean;
    is_superuser?: boolean;
    rolId?: number;
}
