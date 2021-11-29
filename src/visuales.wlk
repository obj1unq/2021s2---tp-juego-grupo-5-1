import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*
import niveles.*
import hud.*

object visual{
	method pj(){
		personaje.reiniciar()
		game.addVisual(personaje)
		game.showAttributes(personaje)
	}
	
}

class Visual{
	var property image
	var property position
}


//object saludo {
//	
//	method position() = game.center()
//	
//	method text() = "¡Para comenzar el juego presione ENTER!"
//}
//
//object dialogo {
//	
//	const tutoriales = ["Hola guerrero","Necesito tu ayuda","para eliminar a los enemigos","Acercate al enemigo y","presiona la tecla A para atacar","cuando mueran nos daran oro"]
//	
//	method inicial(){
//		tutoriales.forEach({
//			texto =>
//			game.say(personaje,texto)
//		})
//	}
//}



