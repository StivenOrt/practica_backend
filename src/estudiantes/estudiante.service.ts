import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateEstudianteDto } from './dto/create-estudiante.dto';
import { Estudiante } from './entities/estudiante.entity';

@Injectable()
export class EstudianteService {
  constructor(
    @InjectRepository(Estudiante)
    private readonly estudianteRepository: Repository<Estudiante>,
  ) {}

  async create(dto: CreateEstudianteDto): Promise<Estudiante> {
    const estudiante = this.estudianteRepository.create(dto);
    return this.estudianteRepository.save(estudiante);
  }

  async findAll(): Promise<Estudiante[]> {
    return this.estudianteRepository.find();
  }
}