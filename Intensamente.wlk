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

  override method liberarse(evento){
    intensidad -= intensidad/3  
  }

 // Los conceptos de herencia y polimorfismo son importantes 
 //debido a que
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

  method liberarEmocion(persona){
    persona.vivirEvento(self)
  }
}