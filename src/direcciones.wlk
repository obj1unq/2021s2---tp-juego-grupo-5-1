
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

object moverse{
	method sobreX(enemigo,pj){
		if(enemigo.position().x() > pj.position().x()){
				enemigo.position(enemigo.position().left(1))
		}
		if(enemigo.position().x() < pj.position().x()){
				enemigo.position(enemigo.position().right(1)) 
		}
	}

	method sobreY(enemigo,pj){
		if(enemigo.position().y() > pj.position().y()){
			enemigo.position(enemigo.position().down(1))
		}
		if(enemigo.position().y() < pj.position().y()){
			enemigo.position(enemigo.position().up(1)) 
		}
	}
}
