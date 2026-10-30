import { Body, Controller, Post } from '@nestjs/common';
import { IsString, MinLength } from 'class-validator';
import { answerVisit } from './guide.service.js';

class AskDto {
  @IsString()
  @MinLength(1)
  question!: string;
}

@Controller('guide')
export class GuideController {
  @Post('ask')
  ask(@Body() body: AskDto) {
    return answerVisit(body.question);
  }
}
