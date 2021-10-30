class Hechizo {
	var property damage 
	var property aprendido
	
}

object fuego inherits Hechizo(damage=10,aprendido=false){}
object rayo inherits Hechizo(damage=9,aprendido=false){}
object hielo inherits Hechizo(damage=3,aprendido=false){}
object escudo inherits Hechizo(damage=0,aprendido=false){}