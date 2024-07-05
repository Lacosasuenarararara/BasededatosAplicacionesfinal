/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.vista;
import edu.mx.uttt.bdapp.entidades.Cliente;
import edu.mx.uttt.bdapp.control.CtrlCliente;


/**
 *
 * @author Usuario
 */
public class VistaCliente {
    public static void main(String[] args) {
         Cliente cl = new Cliente();
         cl.setCustomerId("DSMG3");
         cl.setCompanyName("Gallina de Hule");
         cl.setContactName("Lizeth Kazumi Pando");
         cl.setContactTitle("Gerente de ASI");
         cl.setAddress("Av. Libre");
         cl.setCity("Salte si Puedes");
         cl.setRegion("Este");
         cl.setPostalCode("42800");
         cl.setCountry("irlanda");
         cl.setPhone("7731280028");
         cl.setFax("421543");
         
         //Enviar el objeto cliente al control clientte
         CtrlCliente ctrlCli = new CtrlCliente();
         
         ctrlCli.agregar(cl);
         
    }
    
}
