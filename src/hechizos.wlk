class Hechizo {
	var property damage 
	var property manaRequerida
	
}

object fuego inherits Hechizo(damage=2,manaRequerida=20){}
object rayo inherits Hechizo(damage=3,manaRequerida=20){}
object hielo inherits Hechizo(damage=1,manaRequerida=20){}
object escudo inherits Hechizo(damage=0,manaRequerida=20){}