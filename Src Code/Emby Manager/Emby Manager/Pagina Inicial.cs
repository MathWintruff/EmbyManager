using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Runtime.InteropServices;

namespace EmbyManager
{
    public partial class Form2 : Form
    {
        #region Variables and Global funtions

        SqlHelperClass QuerySender;
        string connectionString;
        ComboBoxValueHelper comboBoxDataAdapter = new ComboBoxValueHelper();

        public void GetConnectionString(string filledConnectionString)
        {
            QuerySender = new SqlHelperClass(filledConnectionString);
            connectionString = filledConnectionString;
        }
        void FullFillAllComboBox()
        {
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'MT'", QuerySender, CmbMediaType);
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'MS'", QuerySender, CmbMediaStatus);
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'SS'", QuerySender, CmbServerStatus);
        }

        public void UpdateTable()
        {
            try
            {
                DataSet MediaDataset = new DataSet();
                string Type, MediaStatus, ServerStatus;
                if(Convert.ToInt32(comboBoxDataAdapter.GetComboBoxValue(CmbMediaType)) < 10)
                {
                    Type = "0";
                }
                else
                {
                    Type = comboBoxDataAdapter.GetComboBoxValue(CmbMediaType);
                }
                if (Convert.ToInt32(comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus)) < 10)
                {
                    MediaStatus = "0";
                }
                else
                {
                    MediaStatus = comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus);
                }
                if (Convert.ToInt32(comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus)) < 10)
                {
                    ServerStatus = "0";
                }
                else
                {
                    ServerStatus = comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus);
                }
                string Search = string.Format("EXEC SearchMediaFiltered '{0}', {1}, {2}, {3};", txtProcurar.Text, Type, MediaStatus, ServerStatus);
                MediaDataset = QuerySender.ReturnQueryResult(Search);
                DtgMedia.DataSource = MediaDataset.Tables[0];
            }
            catch
            {
                MessageBox.Show("Error, Nothing Found", "No Result", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        public void FirstUpdateTable()
        {
            DataSet MediaDataset = new DataSet();
            MediaDataset = QuerySender.ReturnQueryResult("EXEC GetMedia");
            DtgMedia.DataSource = MediaDataset.Tables[0];
        }

        List<string>  GetSelectedMediaString()
        {
            List<string> SelectedItemAtributes = new List<string>();
            DataGridViewRow SelectedRow = DtgMedia.SelectedRows[0];
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["DboCode"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["Tittle"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["EnglishTittle"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["MediaType"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["Status"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["ServerStatus"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["IdCode"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["QtdEpisodes"].Value));
            SelectedItemAtributes.Add(Convert.ToString(SelectedRow.Cells["ReleaseDate"].Value));

            return SelectedItemAtributes;
        }

        
        #region function para arrastar Form

        public const int WM_NCLBUTTONDOWN = 0xA1;
            public const int HT_CAPTION = 0x2;

            [DllImportAttribute("user32.dll")]
            public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
            [DllImportAttribute("user32.dll")]
            public static extern bool ReleaseCapture();
            private void panelControle_MouseMove(object sender, MouseEventArgs e)
            {
                if (e.Button == MouseButtons.Left)
                {
                    ReleaseCapture();
                    SendMessage(Handle, WM_NCLBUTTONDOWN, HT_CAPTION, 0);
                }
            }
        #endregion
        #endregion

        #region Add/Del/Up Functions
        void RemoveMedia()
        {
            for (int i = 0; i < DtgMedia.SelectedRows.Count; i++)
            {

                DataGridViewRow SelectedRow = DtgMedia.SelectedRows[i];
                string CodeOfMediaToRemove = Convert.ToString(SelectedRow.Cells["DboCode"].Value);
                string EnNameOfMediaToRemove = Convert.ToString(SelectedRow.Cells["EnglishTittle"].Value);

                if (MessageBox.Show("Are you sure about this deletion?\nItem to be deleted: " + EnNameOfMediaToRemove, "Deletion Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {

                    QuerySender.ExecuteQuery(string.Format("EXEC RemoveMedia {0}", CodeOfMediaToRemove));
                }
            }
            UpdateTable();
        }

        void UpdateMedia()
        {
            if (DtgMedia.SelectedRows.Count == 1)
            {
                var FormUpdate = new FormUpdate();
                FormUpdate.GetConnectionString(connectionString);
                FormUpdate.GetForm(this);
                FormUpdate.GetSelectedItem(GetSelectedMediaString());
                FormUpdate.ShowDialog();
            }
            else
            {
                MessageBox.Show("Please, select only one media to update at the same time!", "Too Much", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        void AddMedia()
        {
            var FormAdd = new FormAdd();
            FormAdd.GetConnectionString(connectionString);
            FormAdd.GetForm(this);
            FormAdd.ShowDialog();
        }

        #endregion

        #region Inicialization
        public Form2()
        {
            InitializeComponent();
            WindowState = FormWindowState.Maximized;
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            FirstUpdateTable();
            FullFillAllComboBox();
        }
        #endregion

        #region Buttons Tittle Bar
        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnMaximizar_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Maximized;
            btnRestaurar.Visible = true;
            btnMaximizar.Visible = false;
        }

        private void btnRestaurar_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Normal;
            CenterToScreen();
            btnRestaurar.Visible = false;
            btnMaximizar.Visible = true;
        }

        private void btnMinimizar_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        #endregion

        #region Buttons Click
        private void btnAdicionar_Click(object sender, EventArgs e)
        {
            AddMedia();
        }
        private void BtnUpdate_Click(object sender, EventArgs e)
        {
            UpdateMedia();
        }
        private void btnConfig_Click(object sender, EventArgs e)
        {

        }
        private void btnRemover_Click(object sender, EventArgs e)
        {
            RemoveMedia();
        }
        private void btnFiltro_Click(object sender, EventArgs e)
        {
            if (panelFiltro.Visible == true)
                panelFiltro.Visible = false;
            else
                panelFiltro.Visible = true;
        }

        private void btnFiltro2_Click(object sender, EventArgs e)
        {
            if (panelFiltro.Visible == true) {
                panelFiltro.Visible = false;
                UpdateTable();
            }
            else
                panelFiltro.Visible = true;
        }
        #endregion

        #region SqlCommands
        public void GetDatabaseInformation()
        {
            
        }


        #endregion

        #region Events
        private void txtProcurar_Click(object sender, EventArgs e)
        {
            txtProcurar.Text = "";
        }
        private void txtProcurar_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                UpdateTable();
            }
        }
        private void panelControle_DoubleClick(object sender, EventArgs e)
        {
            if (WindowState == FormWindowState.Maximized)
                WindowState = FormWindowState.Normal;
            else
                WindowState = FormWindowState.Maximized;
        }

        #endregion

        #region Search Filter

        #endregion
    }
}