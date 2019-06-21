import gaston.*
import wollok.game.*
import tablero.*
import sacerdote.*
import puerta.*
import paredes.*

class Nivel {

	const ancho = game.width() - 1
	const largo = game.height() - 1

	method agregarCosas()
	
	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}
	
	method cargar() {
		self.agregarCosas(){ 	
			self.cargarBordeV(0)
			self.cargarBordeV(ancho)
			self.cargarBordeH(0)
			self.cargarBordeH(largo)
		}
		game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { e => puerta.pasoNivel2(e)})
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(gaston)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(gaston)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(gaston)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(gaston)})
	}

}

