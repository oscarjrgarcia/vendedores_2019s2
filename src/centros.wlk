import vendedores.*
import lugares.*
import certificaciones.*

class CentroDistribucion {
	const property ciudadEnLaQueEsta
	const property vendedoresQueTrabaja = []
	
	method agregarVendedor(unVendedor) { 
		if (vendedoresQueTrabaja.any({v => v == unVendedor})) { self.error("Vendedor ya registrado")}
		else {vendedoresQueTrabaja.add(unVendedor)}
	}
	
	method vendedorEstrella() = vendedoresQueTrabaja.max({v => v.puntajeTotalCertificaciones()})
	method puedeCubrir(ciudad) = vendedoresQueTrabaja.any({v => v.puedeTrabajar(ciudad)})
	method vendedoresGenericos() = vendedoresQueTrabaja.filter({ v => v.esGenerico()})
	method esRobusto() = vendedoresQueTrabaja.filter({ v => v.esFirme()}).size() >= 3
	
	method repartirCertificacion(certificacion) {vendedoresQueTrabaja.forEach({ v => v.agregarCertificacion(certificacion)})}
}
