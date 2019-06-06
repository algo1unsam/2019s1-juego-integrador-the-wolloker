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

object nivel1 {

	const vertical = 12
	const horizontal = 7
	const ancho = game.width() - 1
	const largo = game.height() - 1

	method cargar() {
		gaston.position(game.at(1, 1))
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
		controladorDeTablero.jugador(gaston)
		jefe.position(game.at(18, 3))
		game.whenCollideDo(gaston, { objeto =>
		if (gaston.estoyMuerto()) objeto.teChocasteConFantasma() else objeto.teChocasteConGaston()
	})
	game.whenCollideDo(sacerdote, { gaston =>
		if (gaston.estoyMuerto()) gaston.revivir()
	})
	game.whenCollideDo(puerta, { e =>
		if (e.tengoLlave()) puerta.ganaste()
	})
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

}

