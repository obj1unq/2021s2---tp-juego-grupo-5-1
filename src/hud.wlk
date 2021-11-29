import visuales.*
import direcciones.*
import wollok.game.*
import personaje.*
import enemigos.*
import niveles.*

//Articulos del HUD
const perfil = new Visual(position= game.at(0,0),image = "hud/cuadrado.png")
const flechaIzq = new Visual(position= game.at(17,0),image = "hud/izquierda.png")
const flechaDer = new Visual(position= game.at(19,0),image = "hud/derecha.png")
const flechaAba= new Visual(position= game.at(18,0),image = "hud/abajo.png")
const flechaArr= new Visual(position= game.at(18,1),image = "hud/arriba.png")
const cuadro= new Visual(position= game.at(13,0),image = "hud/cuadro.png")

//vida
const vida1 = new Visual(position= game.at(2,1),image = "hud/vida.png")
const vida2 = new Visual(position= game.at(3,1),image = "hud/vida.png")
const vida3 = new Visual(position= game.at(4,1),image = "hud/vida.png")
const vida4= new Visual(position= game.at(5,1),image = "hud/vida.png")
const vida5= new Visual(position= game.at(6,1),image = "hud/vida.png")
const vida6= new Visual(position= game.at(7,1),image = "hud/vida.png")
const vida7= new Visual(position= game.at(8,1),image = "hud/vida.png")
const vida8= new Visual(position= game.at(9,1),image = "hud/vida.png")
const vida9= new Visual(position= game.at(10,1),image = "hud/vida.png")
const finalVida= new Visual(position= game.at(11,1),image = "hud/vida2.png")

//mana
const mana1 = new Visual(position= game.at(2,0),image = "hud/mana.png")
const mana2= new Visual(position= game.at(3,0),image = "hud/mana.png")
const mana3= new Visual(position= game.at(4,0),image = "hud/mana.png")
const mana4= new Visual(position= game.at(5,0),image = "hud/mana.png")
const mana5= new Visual(position= game.at(6,0),image = "hud/mana.png")
const mana6= new Visual(position= game.at(7,0),image = "hud/mana.png")
const mana7= new Visual(position= game.at(8,0),image = "hud/mana.png")
const mana8= new Visual(position= game.at(9,0),image = "hud/mana.png")
const mana9= new Visual(position= game.at(10,0),image = "hud/mana.png")
const finalMana= new Visual(position= game.at(11,0),image = "hud/mana2.png")


object hud {
	
	const property barraVida = [vida1,vida2,vida3,vida4,vida5,vida6,vida7,vida8,vida9,finalVida]
	const property barraMana = [mana1,mana2,mana3,mana4,mana5,mana6,mana7,mana8,mana9,finalMana]
	
	method agregarVida(){
		if(barraVida.size() < 10 and barraVida.size() > 0){
			const posicion = barraVida.last().position()
			const nuevo = new Visual(image = "hud/vida.png",position= posicion.right(1))
			barraVida.add(nuevo)
			game.addVisual(nuevo)
		}else if(barraVida.size() == 0){
			const nuevo = new Visual(image = "hud/vida.png",position=game.at(2,1))
			barraVida.add(nuevo)
			game.addVisual(nuevo)	
		}
	}
	
	method agregarVidas(x){
		var contador = x
		game.onTick(50,"sumarVidas",{
			if(contador > 0){
				self.agregarVida()
				contador -= 1
			}else{
				self.desaparecer("sumarVidas")
			}
		})
	}
	
	method desaparecer(evento){
		game.removeTickEvent(evento)
	}
	
	method quitarVida(){
		if(barraVida.size() >= 1){
			const ulti = barraVida.last()
			barraVida.remove(ulti)
			game.removeVisual(ulti)
		}
		
	}
	method quitarVidas(x){
		var contador = x
		game.onTick(50,"quitarVidas",{
			if(contador > 0){
				self.quitarVida()
				contador -= 1
			}else{
				self.desaparecer("quitarVidas")
			}
		})
	}
	
	method agregarMana(){
		if(barraMana.size() < 10 and barraMana.size() > 0){
			const posicion = barraMana.last().position()
			const nuevo = new Visual(image = "hud/mana.png",position= posicion.right(1))
			barraMana.add(nuevo)
			game.addVisual(nuevo)
		}
		else if(barraMana.size() == 0){
			const nuevo = new Visual(image = "hud/mana.png",position=game.at(2,0))
			barraMana.add(nuevo)
			game.addVisual(nuevo)	
		}
	}
	method agregarMana(x){
		var contador = x
		game.onTick(50,"agregarManas",{
			if(contador > 0){
				self.agregarMana()
				contador -= 1
			}else{
				self.desaparecer("agregarManas")
			}
		})
	}
	
	method quitarMana(){
		if(barraMana.size() >= 1){
			const ulti = barraMana.last()
			barraMana.remove(ulti)
			game.removeVisual(ulti)
		}
	}
	method quitarMana(x){
		var contador = x 
		game.onTick(50,"quitarManas",{
			if(contador > 0){
				self.quitarMana()
				contador -= 1
			}else{
				self.desaparecer("quitarManas")
			}
		})
	}
	
	method visualizar(){
		barraVida.forEach({v => game.addVisual(v)})
		barraMana.forEach({m => game.addVisual(m)})	
		game.addVisual(perfil)
		game.addVisual(flechaIzq)
		game.addVisual(flechaDer)
		game.addVisual(flechaAba)
		game.addVisual(flechaArr)
		game.addVisual(cuadro)
	}
	method soloFlechasX(){
		game.removeVisual(flechaAba)
		game.removeVisual(flechaArr)
	}
	method reiniciar(){
		self.agregarVidas(10 - barraVida.size())
		self.agregarMana(10 - barraMana.size())
	}
	
}
