//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using System.Windows;
//using System.Windows.Controls;
//using System.Windows.Data;
//using System.Windows.Documents;
//using System.Windows.Input;
//using System.Windows.Media;
//using System.Windows.Media.Imaging;
//using System.Windows.Shapes;

//namespace VetClinic.window
//{
//    /// <summary>
//    /// Логика взаимодействия для WindowEdit.xaml
//    /// </summary>
//    public partial class WindowEdit : Window
//    {
//        public WindowEdit()
//        {
//            InitializeComponent();
//        }
//    }
//}
using System;
using System.Linq;
using System.Windows;
using VetClinic.db;

namespace VetClinic.window
{
    public partial class WindowEdit : Window
    {
        private Appointment _currentAppointment;

        public WindowEdit(Appointment appointmentToEdit)
        {
            InitializeComponent();
            _currentAppointment = appointmentToEdit;
            LoadData();
            FillForm();
        }

        private void LoadData()
        {
            try
            {
                cbAnimal.ItemsSource = Connection.vetclinicEntities.Animal.ToList();

                cbAnimalType.ItemsSource = Connection.vetclinicEntities.TypeAni.ToList();

                cbAnimalGender.ItemsSource = Connection.vetclinicEntities.Gender.ToList();

                cbDoctor.ItemsSource = Connection.vetclinicEntities.Doctor
                    .Select(d => new {
                        d.ID,
                        FullName = d.LastName + " " + d.Name + " " + d.Patronymic,
                        d.IdTypeDoc
                    })
                    .ToList();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void FillForm()
        {
            if (_currentAppointment != null)
            {
                var animal = Connection.vetclinicEntities.Animal.FirstOrDefault(a => a.ID == _currentAppointment.IDAnimal);
                if (animal != null)
                {
                    cbAnimal.SelectedValue = animal.ID;
                    cbAnimalType.SelectedValue = animal.IdTypeAni;
                    cbAnimalGender.SelectedValue = animal.IdGender;
                    tbWeight.Text = animal.Weight_kg.ToString();
                    tbHeight.Text = animal.Height_cm.ToString();
                }

                cbDoctor.SelectedValue = _currentAppointment.IDDoc;

                dpDate.SelectedDate = _currentAppointment.DateAccep;
                tbComment.Text = _currentAppointment.Comment;
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (cbAnimal.SelectedItem == null ||
                    cbAnimalType.SelectedItem == null ||
                    cbAnimalGender.SelectedItem == null ||
                    cbDoctor.SelectedItem == null ||
                    !dpDate.SelectedDate.HasValue)
                {
                    MessageBox.Show("Пожалуйста, заполните все обязательные поля", "Предупреждение",
                        MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                var animal = (Animal)cbAnimal.SelectedItem;
                animal.IdTypeAni = ((TypeAni)cbAnimalType.SelectedItem).ID;
                animal.IdGender = ((Gender)cbAnimalGender.SelectedItem).ID;
                animal.Weight_kg = double.TryParse(tbWeight.Text, out var weight) ? weight : 0;
                animal.Height_cm = double.TryParse(tbHeight.Text, out var height) ? height : 0;

                _currentAppointment.IDAnimal = animal.ID;
                _currentAppointment.IDDoc = (int)cbDoctor.SelectedItem.GetType().GetProperty("ID").GetValue(cbDoctor.SelectedItem);
                _currentAppointment.DateAccep = dpDate.SelectedDate.Value;
                _currentAppointment.Comment = tbComment.Text;

                Connection.vetclinicEntities.SaveChanges();

                MessageBox.Show("Данные приема успешно обновлены", "Успех",
                    MessageBoxButton.OK, MessageBoxImage.Information);

                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении данных: {ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
