
object arriba {
	method siguiente(posicion){
		return posicion.up(1)
	}
	
	method sufijo(){
		return "der"
	}
	method cambiar(dirOriginal){
		return dirOriginal
	}
}

object abajo {
	method siguiente(posicion){
		return posicion.down(1)
	}
	
	method sufijo(){
		return "der"
	}
	method cambiar(dirOriginal){
		return dirOriginal
	}
}

object izquierda {
	
	method siguiente(posicion){
		return posicion.left(1)
	}
	
	method sufijo(){
		return "izq"
	}
	method cambiar(dirOriginal){
		return self
	}
}

object derecha {
	method siguiente(posicion){
		return posicion.right(1)
	}
	
	method sufijo(){
		return "der"
	}
	method cambiar(dirOriginal){
		return self
	}
}
