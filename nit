using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Domen;
using System.Net;
using System.Net.Sockets;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading;

namespace ServerKonzola
{
    class NitKlijenta
    {
        private NetworkStream tok;
        BinaryFormatter formater;

        public NitKlijenta(NetworkStream tok)
        {
            this.tok = tok;
            formater = new BinaryFormatter();

            ThreadStart ts = obradiKlijenta;
            new Thread(ts).Start();

        }


        void obradiKlijenta()
        {
            try
            {
                int a = 0;
                while (a != (int)Operacije.Kraj)
                {
                    TransferKlasa transfer = formater.Deserialize(tok) as TransferKlasa;
                    switch (transfer.Operacija)
                    {
                        case Operacije.Login:
                            transfer.Rezultat = Broker.dajSesiju().login(transfer.TransferObjekat as PoreskiInspektor);
                            formater.Serialize(tok, transfer);
                            break;

                        case Operacije.VratiSveVrste:
                            transfer.Rezultat = Broker.dajSesiju().vratiSveVrste();
                            formater.Serialize(tok, transfer);
                            break;

                        case Operacije.VratiSveObveznike:
                            transfer.Rezultat = Broker.dajSesiju().vratiSveObveznike();
                            formater.Serialize(tok, transfer);
                            break;
                        case Operacije.SacuvajPrijave:
                            transfer.Rezultat = Broker.dajSesiju().sacuvajPrijavu(transfer.TransferObjekat as PoreskaPrijava);
                            formater.Serialize(tok, transfer);
                            break;


                        case Operacije.Kraj:
                            a = 1;
                            break;
                        default:
                            break;
                    }
                }
            }
            catch (Exception)
            {

                
            }
        }
    }
}
