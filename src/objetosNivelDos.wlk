import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import enemigos.*

class Mago inherits CosaInteractiva {

	override method image() = "mago.png"

	override method teChocasteCon(cosa) {
		if (cosa == gaston and gaston.estaVivo()) gaston.morir()
	}

}

class Arquero inherits Mago {

	override method image() = "arquero.png"

}

class Proyectil inherits CosaInteractiva {

	var imagen
	
	override method image() = imagen

	override method teChocasteCon(cosa) {
		cosa.teGolpeo()
	}

	method tieneLlave() = false
	
	method moverse(posicion){//--------------------------------------------
		self.position(posicion)
	}
}

class Lava inherits Proyectil {
	
	const property tiempo = 1000
	
}

class BolaDeNieve inherits Proyectil {
	
	const property tiempo = 100
	
}

class Obsidiana inherits Proyectil {
	
	const property tiempo = 1000
	
	override method teChocasteCon(cosa) {
		
	}
	
	override method moverse(posicion){
		
		super(posicion)
		
		if(gaston.estaVivo() and gaston.position().up(1) == self.position()){
				gaston.position(self.position())
		}
		
	}
	
}


