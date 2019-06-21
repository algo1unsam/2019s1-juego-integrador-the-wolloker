import paredes.*
import wollok.game.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import puzzle.*
import tablero.*
import objetosNivelDos.*

class Nivel {

	const ancho = game.width() - 1
	const largo = game.height() - 1
	var jugador

	method agregarCosas() {
		game.addVisual(jugador)
		self.cargarBordeV(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(0)
		self.cargarBordeH(largo)
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

	method cargar() {
		controladorDeTablero.sacarTodo()
		self.agregarCosas()
		self.gameConfig()
	}

	method gameConfig() {
		game.whenCollideDo(jugador, { objeto => jugador.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(jugador)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(jugador)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(jugador)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(jugador)})
	}

	method gano()

}

