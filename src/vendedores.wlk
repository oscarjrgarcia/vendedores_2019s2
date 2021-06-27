import lugares.*
import certificaciones.*

class Vendedor {
	const property certificaciones = []
	method puedeTrabajar(ciudad)
	method esVersatil() = certificaciones.size() >= 3 and certificaciones.any({c => c.esDeProducto()}) and certificaciones.any{ c => not c.esDeProducto()}
	method esFirme() = certificaciones.sum({c => c.puntaje()}) >= 30
	method esInfluyente()
	
	method puntajeTotalCertificaciones() = certificaciones.sum({c => c.puntaje()})
	method esGenerico() = certificaciones.any({c => not c.esDeProducto()})
	method agregarCertificacion(certificacion) { certificaciones.add(certificacion)}
	
	method tieneAfinidadPor(centro) = self.puedeTrabajar(centro.ciudadEnLaQueEsta())
	method esCandidato(centro) = self.esVersatil() and self.tieneAfinidadPor(centro)
	
	method esPersonaFisica()
}

class VendedorFijo inherits Vendedor {
	const property ciudadDondeVive
	
	override method puedeTrabajar(ciudad) = ciudad == ciudadDondeVive
	override method esInfluyente() = false
	override method esPersonaFisica() = true
}

class Viajante inherits Vendedor {
	const property provinciasHabilitadas = []
	
	override method puedeTrabajar(ciudad) {
		return provinciasHabilitadas.any({ p => ciudad.provinciaEnLaQueEsta() == p.nombre()})
		}
	override method esInfluyente() = provinciasHabilitadas.sum({ p => p.poblacion()}) >= 10
	override method esPersonaFisica() = true
		
}

class ComercioCorresponsal inherits Vendedor {
	const property ciudadesConSucursales = []
	
	override method puedeTrabajar(ciudad) = ciudadesConSucursales.any({c => c == ciudad})
	override method esInfluyente() = ciudadesConSucursales.size() >= 5 or ciudadesConSucursales.map({c => c.provinciaEnLaQueEsta()}).asSet().size() >= 3 
	override method tieneAfinidadPor(centro) = super(centro) and ciudadesConSucursales.any({ c =>  not centro.puedeCubrir(c)})
	override method esPersonaFisica() = false
}