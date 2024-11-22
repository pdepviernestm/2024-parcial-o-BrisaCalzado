class Emociones{
  var property intensidadElevada
  var property intensidad 
  var property eventosVividos = 0

  method sumarEvento(){
    eventosVividos += 1
  }

  method tieneIntensidadElevada(){
    return intensidad > intensidadElevada
  }

  method puedeLiberarseEmocion(){
    return self.tieneIntensidadElevada()
  }

  method liberarse(evento){
    intensidad -= evento.impacto()
  }
   
}

class Furia inherits Emociones(intensidad = 100){
  const palabrotas = #{} 

  override method puedeLiberarseEmocion(){
    return super() && 
    palabrotas.any{palabrota => palabrota.size() > 7}
  }
 
  override method liberarse(evento){
    super(evento)
    palabrotas.remove(palabrotas.first())
  }
}

class Alegria inherits Emociones{
  
  override method puedeLiberarseEmocion(){
    return super() && 
    eventosVividos %2 == 0
  }
  
  override method liberarse(evento){
      super(evento)
      intensidad = intensidad.abs()
  }
}

class Tristeza inherits Emociones{
  var property causa = "melancolia"

  override method liberarse(evento){
    self.causa(evento.descripcion())
    super(evento)
  }

}

class DesagradoYTemor inherits Emociones{
  
  override method puedeLiberarseEmocion(){
    return super() && 
    eventosVividos > intensidad
  }
}

class Ansiedad inherits Emociones{
  var momentosVergonzosos 

  override method puedeLiberarseEmocion(){
    return super() && 
    momentosVergonzosos > 3
  }

  override method liberarse(evento){
    intensidad -= intensidad/3  
    momentosVergonzosos -= 1
  }

  /* Los conceptos de herencia y polimorfismo fueron importantes debido a que permiten la reutilización del código. 
  La herencia permite que una clase obtenga de otra sus métodos y variables, lo que evita la duplicación de código 
  y facilita el mantenimiento. En este ejemplo, las clases de emociones heredan de la clase Emociones, 
  compartiendo comportamientos comunes y modificandose cuando es necesario. Por otro lado, el polimorfismo
  permite que diferentes objetos respondan a los mismos métodos, lo que simplifica la interacción con objetos 
  de distintas clases. Esto se puede ver cuando se llama a los métodos puedeLiberarseEmocion y liberarse en las 
  distintas emociones, permitiendo que cada emoción implemente su propia versión del comportamiento.*/
}

class Persona{
  var edad
  const property emociones = #{}
  
  method esAdolescente(){
    return edad.between(12, 18)
  }

  method adquirirEmocion(emocion){
    emociones.add(emocion)
  }

  method vivirEvento(evento){
    emociones.forEach{em => em.sumarEvento()}
    emociones.forEach{em => if(em.puedeLiberarseEmocion()) em.liberarse(evento)}
  }

  method estaPorExplotar() = emociones.all{emocion => emocion.puedeLiberarse()}
}

class Grupo{
  var personas = #{} 

  method agregarPersona(persona){
    personas.add(persona)
  }

  method vivirEvento(evento){
    personas.forEach{persona => persona.vivirEvento(evento)}
  }
}

class Evento{
  var property impacto
  var descripcion 
}
