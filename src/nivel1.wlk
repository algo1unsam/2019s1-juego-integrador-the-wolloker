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
import Nivel.*

object nivel1 inherits Nivel {

	const vertical = 12
	const horizontal = 6

	override method cargar() {
		game.sound("round1.mp3")
		player = gaston1
		super()
	}

	override method gameConfig() {
		super()
		game.whenCollideDo(puerta, { cosa => puerta.pasoNivel1(cosa)})
		movedor.moverNivel1()
	}

	override method agregarCosas() {
		player.position(game.at(1, 1))
		game.addVisualIn(sacerdote, game.at(11, 1))
		game.addVisual(jefe)
		game.addVisual(espada)
		game.addVisual(armadura)
		game.addVisual(enigma)
		game.addVisual(zombie)
		game.addVisualIn(puerta, game.at(21, 1))
		self.cargarLineaCentralV()
		self.cargarLineaCentralH()
		super()
	}

	method plantarBomba() {
		const bombita = new Proyectil(imagen = "bomba.png", position = game.at(14.randomUpTo(ancho - 2), 2.randomUpTo(largo - 2)))
		const fireD = new Proyectil(imagen = "explosion3.png", position = bombita.position().down(2))
		const fireU = new Proyectil(imagen = "explosion3.png", position = bombita.position().up(2))
		const fireR = new Proyectil(imagen = "explosion3.png", position = bombita.position().right(2))
		const fireL = new Proyectil(imagen = "explosion3.png", position = bombita.position().left(2))
		const explosion =  new Proyectil (imagen = "explosion3.png", position =  bombita.position())
		const apagar = { game.removeVisual(fireD)
			game.removeVisual(fireU)
			game.removeVisual(fireR)
			game.removeVisual(fireL)
			game.removeVisual(explosion)
			self.plantarBomba()
		}
		const explotar = { game.removeVisual(bombita)
			game.addVisual(explosion)
			game.addVisual(fireD)
			game.addVisual(fireU)
			game.addVisual(fireR)
			game.addVisual(fireL)
			scheduler.schedule(600, apagar)
		}
		if (jefe.estaVivo()) {
			bombita.aparecer()
			scheduler.schedule(700, explotar)
		}
	}

	method cargarLineaCentralV() {
		new Range(1,largo-3).forEach({ n => game.addVisualIn(new Pared(), game.at(vertical, n))})
	}

	method cargarLineaCentralH() {
		new Range(2,vertical-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, horizontal))})
	}

	override method gano() {
		game.sound("portal.mp3")
		puzzle.cargar()
		gaston1.tirarEquipo(llave)
		gaston2.copiarEquipo(gaston1.equipo())
	}

}

