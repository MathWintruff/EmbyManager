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
    public partial class FormUpdate : Form
    {
        #region Variables and Global funtions
        SqlHelperClass QuerySender;
        DataSet QueryResultDataSet = new DataSet();
        ComboBoxValueHelper comboBoxDataAdapter = new ComboBoxValueHelper();
        Form2 FormPrincipal;
        string DboCode;
        List<string> SelectedItem = new List<string>();

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
        string GetMediaString()
        {
            string Name = TxtName.Text;
            string EnglishName = TxtEnglishName.Text;
            string MediaType = comboBoxDataAdapter.GetComboBoxValue(CmbMediaType);
            string IdMedia = TxtId.Text;
            string QtdEpisodes = TxtQtdEpisodes.Text;
            string MediaStatus = comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus);
            string ServerStatus = comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus);
            string Date = DtpMediaDate.Value.ToString("yyyy-MM-dd");

            return string.Format("EXEC UpdateMedia {0}, '{1}', '{2}', {3}, {4}, {5}, {6}, {7}, '{8}';", DboCode, Name, EnglishName, MediaType, MediaStatus, ServerStatus, IdMedia, QtdEpisodes, Date);
        }
        public void GetSelectedItem(List<string> RecivedSelectedItem)
        {
            SelectedItem = RecivedSelectedItem;
        }

        void CompleteForm()
        {
            DboCode = SelectedItem[0];
            TxtName.Text = SelectedItem[1];
            TxtEnglishName.Text = SelectedItem[2];
            comboBoxDataAdapter.SetComboBoxValue(CmbMediaType, SelectedItem[3]);
            comboBoxDataAdapter.SetComboBoxValue(CmbMediaStatus, SelectedItem[4]);
            comboBoxDataAdapter.SetComboBoxValue(CmbServerStatus, SelectedItem[5]);
            TxtId.Text = SelectedItem[6];
            TxtQtdEpisodes.Text = SelectedItem[7];
            DtpMediaDate.Text = SelectedItem[8];
        }
        #endregion

        #region Inicialization
        public FormUpdate()
        {
            InitializeComponent();
        }
        private void FormUpdate_Load(object sender, EventArgs e)
        {
            FullFillAllComboBox();
            CompleteForm();
        }
        #endregion

        #region Buttons Click
        private void BtnUpdate_Click(object sender, EventArgs e)
        {
            if (TxtName.Text == "" || TxtEnglishName.Text == "" || comboBoxDataAdapter.GetComboBoxValue(CmbMediaStatus) == null || comboBoxDataAdapter.GetComboBoxValue(CmbMediaType) == null || comboBoxDataAdapter.GetComboBoxValue(CmbServerStatus) == null)
            {
                MessageBox.Show("Names cannot be blank!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                
                QuerySender.ExecuteQuery(GetMediaString());
                FormPrincipal.UpdateTable();
                this.Close();
            }

        }

        private void BtnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion

        #region Events
        private void FormUpdate_KeyPress(object sender, KeyPressEventArgs e)
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
