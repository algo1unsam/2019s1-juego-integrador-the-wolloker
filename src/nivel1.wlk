import paredes.*
import wollok.game.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import puzzle.*
import tablero.*

object nivel1 {

	const vertical = 12
	const horizontal = 7
	const ancho = game.width() - 1
	const largo = game.height() - 1

	method cargar() {
		self.agregarCosas()
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(gaston)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(gaston)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(gaston)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(gaston)})
		game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { cosa => puerta.pasoNivel1()})
		pepita.moverNivel1()
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

	method cargarLineaCentralV() {
		new Range(1,largo-2).forEach({ n => game.addVisualIn(new Pared(), game.at(vertical, n))})
	}

	method cargarLineaCentralH() {
		new Range(2,vertical-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, horizontal))})
	}

	method agregarCosas() {
		game.addVisual(gaston)
		game.addVisualIn(sacerdote, game.at(11, 1))
		game.addVisual(jefe)
		game.addVisual(espada)
		game.addVisual(armadura)
		game.addVisual(casco)
		game.addVisualIn(enigma, game.at(2, 4))
		game.addVisualIn(zombie, game.at(8, 11))
		game.addVisualIn(puerta, game.at(21, 1))
		self.cargarBordeV(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(0)
		self.cargarBordeH(largo)
		self.cargarLineaCentralV()
		self.cargarLineaCentralH()
	}

	method gano() {
		puzzle.cargar()
	}

}

