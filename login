using Domen;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Klijent
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Komunikacija k = new Klijent.Komunikacija();
            if (k.poveziSeNaServer())
            {
                PoreskiInspektor p = new PoreskiInspektor();
                p.KorisnickoIme = txtUser.Text;
                p.KorisnickaSifra = txtPass.Text;

                p = k.login(p);

                if (p == null)
                {
                    MessageBox.Show("Neupselo logovanje!");
                }
                else
                {
                    new FormKlijent(p, k).ShowDialog();
                }
            }
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void txtUser_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPass_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
