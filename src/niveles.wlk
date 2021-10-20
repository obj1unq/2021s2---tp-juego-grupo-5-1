import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*

object tutorial {
	method iniciar(){
		game.addVisual(personaje)
		game.showAttributes(personaje)
		
		self.armas()
		self.enemigos()
		
		config.configurarTeclas()
		config.configurarStamina()
	}
	
	method armas(){
		game.addVisual(hacha)
		game.addVisual(espada)
		game.addVisual(lanza)
		game.addVisual(daga)
	}
	
	method enemigos(){
		const escorpion = new Enemigo(image="escorpion.png",position=game.at(8,8))
		const hiena = new Enemigo(image="hiena.png",position=game.at(8,5))
		const goblin = new Enemigo(image="enemigos/Goblin/Idle/1.png",position=game.at(3,5))
		
		game.addVisual(escorpion)
		game.addVisual(hiena)
		game.addVisual(goblin)
		game.addVisual(brujo)
		
		game.showAttributes(escorpion)
		game.showAttributes(hiena)
		game.showAttributes(brujo)
		game.showAttributes(goblin)
	}
}

object config{
	method configurarTeclas(){
		self.equiparse()
		self.movimientos()
		
		keyboard.s().onPressDo({personaje.guardar()})
		
		keyboard.q().onPressDo({personaje.curarse()})
//		keyboard.i().onPressDo({personaje.abrirInventario()})
	}
	
	method equiparse(){
		keyboard.num1().onPressDo({personaje.armarse(espada)})
		keyboard.num2().onPressDo({personaje.armarse(hacha)})
		keyboard.num3().onPressDo({personaje.armarse(daga)})
		keyboard.num4().onPressDo({personaje.armarse(lanza)})
	}
	
	method movimientos(){
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.up().onPressDo(   { personaje.mover(arriba)})
		keyboard.down().onPressDo( { personaje.mover(abajo)})
		keyboard.a().onPressDo({personaje.atacarEnemigoAdelante()})
	}
	
	method potas(){
		keyboard.q().onPressDo({personaje.curarse()})
		//keyboard.w().onPressDo({personaje.curarse(larga)})
		//keyboard.e().onPressDo({personaje.curarse(stamina)})
		//keyboard.r().onPressDo({personaje.curarse(veneno)})
	}
	
	
	method configurarStamina(){
	   game.onTick(900, "STAMINA", { personaje.recuperarStamina(1)})
    }
	
}

