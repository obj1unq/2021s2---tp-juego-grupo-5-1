import wollok.game.*
import personaje.*

class Pocion{
	var property position
	const property poder
	var property image
	var contenedor = null
	
	method usar(_personaje){
		_personaje.sumarVida(poder)
		game.removeVisual(self)
	}

	method validarGuardado(){}
	
	method agregadoEn(_contenedor){
		contenedor = _contenedor
	}
	
	method position(){
		return if(contenedor != null){
			contenedor.dondeEstoy(self)
		}else{
			position
		}
	}
}



class Oro{
	var property cantidad 
}

object pocasMonedasDeOro inherits Oro(cantidad = (1 .. 5).anyOne()){}
object moderadasMonedasDeOro inherits Oro(cantidad = (6 .. 10).anyOne()){}
object muchasMonedasDeOro inherits Oro(cantidad = (11 .. 20).anyOne()){}

object mostrarOro{
	var property position = game.at(0,0)
	method text() = "oro:  " + inventario.cantidadDeOro()
}

class Templo{
	var property position 
	var property image
	
	method activar(){ }
}

//DEFINICION DE TEMPLO

object temploDeMana inherits Templo(position = game.at(2,2), image="vida.png") {
	
	override method activar(){
		personaje.concentrar()
	}
}


object temploDeExperiencia inherits Templo(position = game.at(4,8),image = "temploExperiencia.png"){
	override method activar(){
		personaje.experienciaDoble()
	}
}

class Diamante{
	const oro 
	const property image
	var property position
	
	method bajar(){
		game.onTick(100,"bajar",{
			if(position.y() > 3 ){
				position = position.down(1)
				self.validarEncuentro()
			}else{
				self.validarFin()
			}
			
		})
	}
	method validarEncuentro(){
		if(game.hasVisual(self)){
			const elementos = game.colliders(self)
			if(elementos.contains(personaje)){
				self.darRecompensaDeOro()
				self.desaparecer()
			}
		}
	}
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
			game.removeTickEvent("bajar")
		}
	}
	method darRecompensaDeOro(){
		inventario.sumarOro(oro)
	}
	method validarFin(){
		game.onTick(10,"enEspera",{self.validarEncuentro()})
			game.schedule(2000,{
				game.removeTickEvent("enEspera")
				self.desaparecer()
			})
	}
}

object fabricaDiamantes{
	var property cant = 0  
	const property imagenes = ["items/1.png","items/2.png","items/3.png","items/4.png","items/5.png","items/6.png","items/7.png"]
	method posicionar(){
		if(cant < 20){
		const posicion = game.at(0.randomUpTo(20).roundUp(),14)
		const diamanteNuevo =self.nuevo(posicion)
		game.addVisual(diamanteNuevo)
		diamanteNuevo.bajar()
		cant += 1
		}else {
			self.detener()
		}
		
	}
	method iniciar(){
		game.onTick(1000,"crearDiamantes",{self.posicionar()})
	}
	method detener(){
		game.removeTickEvent("crearDiamantes")
		self.darConteo()
		game.schedule(2000,{game.stop()})
	}
	method darConteo(){
		game.say(personaje,"Tu puntuacion final es: " + (inventario.cantidadDeOro() / 40).min(10))
	}
	method nuevo(posicion){
		return new Diamante(oro = (2 .. 20).anyOne(),position = posicion,image = imagenes.get((0 .. 6).anyOne()))
	}
	
}





