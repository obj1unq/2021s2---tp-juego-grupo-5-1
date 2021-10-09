import wollok.game.*

object escorpion {
	var property position = game.at(8,8)
	var property hp = 6
	const property experienciaAlMorir = 2
	
	method image() = "escorpion.png"
	
	method pierdeVida(){
		hp -= 1
	}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
		}
	}
	
	method noTieneMasVida(){
		return hp == 0
	}
	
}
