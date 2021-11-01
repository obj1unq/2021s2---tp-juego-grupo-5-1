import wollok.game.*
import personaje.*

//class Arma {
//	var property position
//	var property poder
//	var property image
//	var contenedor = null
//	
//	method usar(_personaje){
//		_personaje.arma(self)
//		_personaje.poder(self.poder())
//	}
//	
//	method neutral(){
//		return true
//	}
//	method validarGuardado(){}
//	
//	method agregadoEn(_contenedor){
//		contenedor = _contenedor
//	}
//	
//	method position(){
//		return if(contenedor != null){
//			contenedor.dondeEstoy(self)
//		}else{
//			position
//		}
//	}
//}
//	
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
	var property position = game.at(2,2)
	method text() = "oro:  " + inventario.cantidadDeOro()
}

class Templo{
	var property position 
	var property image
	
	method activar(){ }
}

//DEFINICION DE TEMPLO
//const temploDeMana = new Templo (position = game.at(2,2), image= "vida.png")
//const temploDeExperiencia = new Templo (position = game.at(2,3), image="vida.png")

object temploDeMana inherits Templo(position = game.at(2,2), image="vida.png") {
	
	override method activar(){
		player.concentrar()
	}
}


object temploDeExperiencia inherits Templo(position = game.at(5,8),image = "temploExperiencia.png"){
	override method activar(){
		player.experienciaDoble()
	}
}





