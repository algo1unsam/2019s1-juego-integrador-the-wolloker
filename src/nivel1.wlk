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

object nivel1 {

	const vertical = 12
	const horizontal = 6
	const ancho = game.width() - 1
	const largo = game.height() - 1

	method plantarBomba() {
		const bombita = new Proyectil(imagen = "bomba.png", position = game.at(14.randomUpTo(ancho - 2), 2.randomUpTo(largo - 2)))
		const fireD = new Proyectil(imagen = "estrellaninja.png", position = bombita.position().down(1))
		const fireU = new Proyectil(imagen = "estrellaninja.png", position = bombita.position().up(1))
		const fireR = new Proyectil(imagen = "estrellaninja.png", position = bombita.position().right(1))
		const fireL = new Proyectil(imagen = "estrellaninja.png", position = bombita.position().left(1))
		const apagar = { game.removeVisual(fireD)
			game.removeVisual(fireU)
			game.removeVisual(fireR)
			game.removeVisual(fireL)
			self.plantarBomba()
		}
		const explotar = { game.removeVisual(bombita)
			game.addVisual(fireD)
			game.addVisual(fireU)
			game.addVisual(fireR)
			game.addVisual(fireL)
			scheduler.schedule(600, apagar)
		}
		bombita.aparecer()
		scheduler.schedule(700, explotar)
	}



	method cargar() {
		self.agregarCosas()
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(gaston)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(gaston)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(gaston)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(gaston)})
		game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { cosa => puerta.pasoNivel1(cosa)})
		movedor.moverNivel1()
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

	method cargarLineaCentralV() {
		new Range(1,largo-3).forEach({ n => game.addVisualIn(new Pared(), game.at(vertical, n))})
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
		game.addVisual(enigma)
		game.addVisual(zombie)
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

