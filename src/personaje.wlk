import wollok.game.*

object personaje {

	var property position = game.origin()

	method image() = "pj-demo2.png"
	
	method irA(nuevaPosition){
		position = nuevaPosition
	}

}