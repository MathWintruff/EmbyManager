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
    public partial class FormAdd : Form
    {
        #region Variables and Global funtions
        SqlHelperClass QuerySender;
        ComboBoxValueHelper comboBoxDataAdapter = new ComboBoxValueHelper();
        Form2 FormPrincipal;

        public void GetForm(Form2 PassedForm)
        {
            FormPrincipal = PassedForm;
        }

        public void GetConnectionString(string filledConnectionString)
        {
            QuerySender = new SqlHelperClass(filledConnectionString);
        }
        void FullFillAllComboBox()
        {
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'MT'", QuerySender, CmbMediaType);
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'MS'", QuerySender, CmbMediaStatus);
            comboBoxDataAdapter.FullFillComboBox("EXEC GetGenericInformation 'SS'", QuerySender, CmbServerStatus);
        }
        string GetAddMediaString()
        {
            string Name = TxtName.Text;
            string EnglishName = TxtEnglishName.Text;
            string MediaType = comboBoxDataAdapter.GetComboBoxValue(CmbMediaType);
            string IdMedia = TxtId.Text;
            string QtdEpisodes = TxtQtdEpisodes.Text;
            string MediaStatus = comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus);
            string ServerStatus = comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus);
            string Date = DtpMediaDate.Value.ToString("yyyy-MM-dd");

            return string.Format("EXEC AddMedia '{0}', '{1}', {2}, {3}, {4}, {5}, {6}, '{7}';", Name, EnglishName, MediaType, MediaStatus, ServerStatus, IdMedia, QtdEpisodes, Date);
        }
        void FormClean()
        {
            TxtName.Clear();
            TxtEnglishName.Clear();
            TxtId.Clear();
            TxtQtdEpisodes.Clear();
            CmbMediaType.SelectedIndex = 0;
            CmbMediaStatus.SelectedIndex = 0;
            CmbServerStatus.SelectedIndex = 0;
            DtpMediaDate.Value = DateTime.Today;
        }
        #endregion

        #region Inicialization
        public FormAdd()
        {
            InitializeComponent();
        }
        private void FormAdd_Load(object sender, EventArgs e)
        {
            FullFillAllComboBox();
            DtpMediaDate.Value = DateTime.Today;
        }
        #endregion

        #region Buttons Click
        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (TxtName.Text == "" || TxtEnglishName.Text == "" || comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus) == null || comboBoxDataAdapter.GetComboBoxValue(CmbMediaType) == null|| comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus) == null)
            {
                MessageBox.Show("Names cannot be blank!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                QuerySender.ExecuteQuery(GetAddMediaString());
                FormPrincipal.UpdateTable();
                FormClean();
            }            
            
        }

        private void btnAddClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion

        #region Events
        private void FormAdd_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((Keys)e.KeyChar == Keys.Escape)
            {
                this.Close();
                e.Handled = true;
            }
        }
        private void TxtId_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!((e.KeyChar > 47 && e.KeyChar < 58) || e.KeyChar == 8 || e.KeyChar == (char)Keys.Enter))
            {
                e.Handled = true;
            }
        }
        #endregion
    }
}