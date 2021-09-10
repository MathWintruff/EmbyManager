using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Windows.Forms;

namespace EmbyManager
{
    class ComboBoxValueHelper
    {
        public string CdInfo { get; set; }

        public string NmInfo { get; set; }

        public string GetComboBoxValue(ComboBox CurrentComboBox)
        {
            ComboBoxValueHelper CurrentComboBoxInfoList = CurrentComboBox.SelectedItem as ComboBoxValueHelper;
            return Convert.ToString(CurrentComboBoxInfoList.CdInfo);
        }
        public void SetComboBoxValue(ComboBox CurrentComboBox, string Value)
        {
            CurrentComboBox.Text = Value;
        }

        public void FullFillComboBox(string SP, SqlHelperClass SqlQuerrySender, ComboBox ComboBoxToBeFilled)
        {
            DataSet QueryResultDataSet = new DataSet();
            List<ComboBoxValueHelper> CurrentFullInfoList = new List<ComboBoxValueHelper>();

            QueryResultDataSet = SqlQuerrySender.ReturnQueryResult(SP);

            CurrentFullInfoList.Add(new ComboBoxValueHelper() { CdInfo = null, NmInfo = ComboBoxToBeFilled.Text });


            for (int i = 0; i < QueryResultDataSet.Tables[0].Rows.Count; i++)
            {
                CurrentFullInfoList.Add(new ComboBoxValueHelper() { CdInfo = Convert.ToString(QueryResultDataSet.Tables[0].Rows[i][0]), NmInfo = Convert.ToString(QueryResultDataSet.Tables[0].Rows[i][1]) });
            }

            ComboBoxToBeFilled.DataSource = CurrentFullInfoList;
            ComboBoxToBeFilled.DisplayMember = "NmInfo";

        }
    }

}
