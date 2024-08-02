import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.setGlobalPrefix('api/v1')

  const config = new DocumentBuilder()
    .setTitle('Electronica')
    .setDescription('The electronic API description')
    .setVersion('1.0')
    .addTag('electronic')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('docs', app, document);


  await app.listen(3000);
}
bootstrap();
