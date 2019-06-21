import wollok.game.*
import paredes.*
import puzzle.*
import tablero.*
import enemigos.*
import objetos.*
import jugador.*
import objetosNivelDos.*

object gaston1 inherits Jugador {

	const property derrotados = []

	method derrotasteA(enemy) {
		derrotados.add(enemy)
	}

}

object gaston2 inherits Jugador {

	var siguiendoA = nada
	

	method siguiendoA(alguien) {
		siguiendoA = alguien
	}

	method dejarDeSeguir() {
		
		siguiendoA.dejarDeLlevar()
	}

	method puedeSerLlevado() = estaVivo

	method seguir(posicion) {
		self.position(posicion)
	}

	override method moverse(posicion) {
		super(posicion)
		if (self.posicionValida(posicion)) self.dejarDeSeguir()
	}

//	method teGolpeo() {
//		self.moverseA(self.position().left(1))
//		if (self.golpes() == 0) {
//			game.addVisualIn(escudo, game.at(1.randomUpTo(14), 1.randomUpTo(18)))
//			equipo.clear()
//			self.conCasco()
//		} else {
//			self.morir()
//		}
//	}
}

