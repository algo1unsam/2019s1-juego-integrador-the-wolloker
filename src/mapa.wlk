import mapa.*
import paredes.*
import tablero.*
import wollok.game.*
import mapa.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import objetosNivelDos.*


object nivel2 {

	const ancho = game.width() - 1
	const largo = game.height() - 1

	method cargar() {
		gaston.position(game.at(1, 6))
		game.addVisual(gaston)
		game.addVisualIn(sacerdote, game.at(1, 1))
		game.addVisual(bolaAbajo1)
		game.addVisualIn(new Mago(), game.at(3, 12))
		game.addVisual(bolaArriba1)
		game.addVisualIn(new Mago(), game.at(6, 1))
		game.addVisual(flechaAbajo1)
		game.addVisualIn(new Arquero(), game.at(9, 12))
		game.addVisual(flechaArriba1)
		game.addVisualIn(new Arquero(), game.at(12, 1))
		game.addVisual(bolaAbajo2)
		game.addVisualIn(new Mago(), game.at(15, 12))
		game.addVisual(bolaArriba2)
		game.addVisualIn(new Mago(), game.at(18, 1))
		game.addVisualIn(puerta, game.at(22, 6))
		self.cargarBordeV(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(0)
		self.cargarBordeH(largo)
	
			
	game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { e =>
			 puerta.gameOver()
		})
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

}

