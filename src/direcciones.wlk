
object arriba {
	method siguiente(posicion){
		return posicion.up(1)
	}
	
	method sufijo(){
		return "up"
	}
}

object abajo {
	method siguiente(posicion){
		return posicion.down(1)
	}
	
	method sufijo(){
		return "down"
	}
}

object izquierda {
	
	method siguiente(posicion){
		return posicion.left(1)
	}
	
	method sufijo(){
		return "izq"
	}
}

object derecha {
	method siguiente(posicion){
		return posicion.right(1)
	}
	
	method sufijo(){
		return "der"
	}
}
