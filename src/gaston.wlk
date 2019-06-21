import wollok.game.*
import paredes.*
import puzzle.*
import tablero.*
import enemigos.*
import objetos.*
import jugador.*

object gaston1 inherits Jugador {

	const property derrotados = []

	override method morir() {
		super()
		self.dejarEquipo()
	}

	method dejarEquipo() {
		equipo.forEach{ objeto => objeto.aparecer()}
		self.tirarTodo()
	}

	method derrotasteA(enemy) {
		derrotados.add(enemy)
	}
	
	
}

object gaston2 inherits Jugador {
//
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

