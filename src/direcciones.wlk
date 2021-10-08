
object arriba {
	method siguiente(posicion){
		return posicion.up(1)
	}
	
	method sufijo(){
		return "der"
	}
	method esVertical(){
		return true
	}
}

object abajo {
	method siguiente(posicion){
		return posicion.down(1)
	}
	
	method sufijo(){
		return "der"
	}
	method esVertical(){
		return true
	}
}

object izquierda {
	
	method siguiente(posicion){
		return posicion.left(1)
	}
	
	method sufijo(){
		return "izq"
	}
	method esVertical(){
		return false
	}
}

object derecha {
	method siguiente(posicion){
		return posicion.right(1)
	}
	
	method sufijo(){
		return "der"
	}
	method esVertical(){
		return false
	}
}
