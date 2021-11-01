 import wollok.game.*
object randomizer {
        
    method position() {
        return     game.at( 
                    (2 .. game.width() - 2 ).anyOne(),
                    (2..  game.height() - 2).anyOne()
        ) 
    }
    
    method emptyPosition() {
        const position = self.position()
        if(game.getObjectsIn(position).isEmpty()) {
            return position    
        }
        else {
            return self.emptyPosition()
        }
    }
    
} 
