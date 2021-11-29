
object arriba {
	method siguiente(posicion){
		if(posicion.y() < 8){
			return posicion.up(1)
		}
		else{return posicion}
	}
	
	method sufijo(){
		return "up"
	}
}

object abajo {
	method siguiente(posicion){
		if(posicion.y() > 2){
			return posicion.down(1)
		}
		else{return posicion}
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
			enemigo.direccion(izquierda)
			enemigo.position(enemigo.position().left(1))
		}
		if(enemigo.position().x() < pj.position().x()){
			enemigo.direccion(derecha)
			enemigo.position(enemigo.position().right(1)) 
		}
	}
	
	method sobreY(enemigo,pj){
		if(enemigo.position().y() > pj.position().y() and enemigo.position().y() > 2){
			enemigo.position(enemigo.position().down(1))
		}
		if(enemigo.position().y() < pj.position().y() and enemigo.position().y() < 8){
			enemigo.position(enemigo.position().up(1)) 
		}
	}
	method moverAtaque(ataque){
		ataque.position(ataque.position().left(1))
	}
	
	method perfilarse(enemigo,pj){
		if(enemigo.position().x() > pj.position().x()){
			enemigo.direccion(izquierda)
		}
		if(enemigo.position().x() < pj.position().x()){
			enemigo.direccion(derecha)
		}
	}

}
