using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EmbyManager
{
    public partial class Form1 : Form
    {
        #region Variables and Global funtions

        static string connectionString;
        public Form2 FormPaginaInicial = new Form2();

        public void LoginConection(string User, string Password)
        {
            if (txtUsuario.TextLength != 0 && txtPassword.TextLength != 0)
            {
                connectionString = string.Format("Data Source=duodebug.ddns.net;Initial Catalog=EmbyManager;Persist Security Info=True;User ID={0};Password={1}", User, Password);
                SqlHelperClass SqlLoginTest = new SqlHelperClass(connectionString);


                if (SqlLoginTest.IsConnection)
                {
                    this.Hide();
                    FormPaginaInicial.GetConnectionString(connectionString);
                    FormPaginaInicial.Show();
                }
                else lblSenhaInvalida.Visible = true;
            }
            else MessageBox.Show("Por favor, digite um usuario e senha validos","Login Invalido",MessageBoxButtons.OK,MessageBoxIcon.Warning);
        }
        #endregion

        #region Inicialization
        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Activated(object sender, EventArgs e)
        {
            txtUsuario.Focus();
        }
        #endregion

        #region Buttons Click
        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
            LoginConection(txtUsuario.Text, txtPassword.Text);
        }
        #endregion

        #region Events
        private void txtUsuario_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                txtPassword.Focus();
                e.Handled = true;
            }

        }
        private void txtPassword_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((Keys)e.KeyChar == Keys.Enter)
            {
                LoginConection(txtUsuario.Text, txtPassword.Text);
                e.Handled = true;
            }

        }
        private void txtPassword_Enter(object sender, EventArgs e)
        {
            lblSenhaInvalida.Visible = false;
        }

        private void txtUsuario_Enter(object sender, EventArgs e)
        {
            lblSenhaInvalida.Visible = false;
        }
        #endregion
    }
}