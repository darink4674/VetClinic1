//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Windows;
//using System.Windows.Controls;
//using VetClinic.db;

//namespace VetClinic.window
//{
//    public partial class WindowAppointment : Window
//    {
//        public List<Appointment> appointments { get; set; }

//        public WindowAppointment()
//        {
//            InitializeComponent();
//            LoadAppointments();
//        }

//        private void LoadAppointments()
//        {
//            appointments = Connection.vetclinicEntities.Appointment.ToList();
//            dgAppointments.ItemsSource = appointments;
//        }

//        private void AddAppointment_Click(object sender, RoutedEventArgs e)
//        {
//            var windowAdd = new WindowAdd();
//            windowAdd.DataSaved += () =>
//            {
//                // Обновляем данные при срабатывании события
//                appointments = Connection.vetclinicEntities.Appointment.ToList();
//                dgAppointments.ItemsSource = appointments;
//            };
//            windowAdd.ShowDialog();
//        }



//        private void Search_Click(object sender, RoutedEventArgs e)
//        {
//            string search = txtSearch.Text.Trim();
//            if (search == "")
//                dgAppointments.ItemsSource = appointments.ToList();
//            else
//                dgAppointments.ItemsSource = appointments.Where(i => i.Animal.Name.ToString() == search).ToList();
//        }

//        private void EditAppointment_Click(object sender, RoutedEventArgs e)
//        {

//            if (dgAppointments.SelectedItem is Appointment selectedAppointment)
//            {
//                WindowEdit windowEdit = new WindowEdit(selectedAppointment);
//                windowEdit.ShowDialog();
//                appointments = new List<Appointment>(Connection.vetclinicEntities.Appointment.ToList());
//                dgAppointments.ItemsSource = appointments;
//            }
//            else
//            {
//                MessageBox.Show("Пожалуйста, выберите прием для редактирования", "Предупреждение",
//                    MessageBoxButton.OK, MessageBoxImage.Warning);
//            }
//        }

//        private void DeleteAppointment_Click(object sender, RoutedEventArgs e)
//        {
//            if (dgAppointments.SelectedItem is Appointment selectedAppointment)
//            {
//                var result = MessageBox.Show("Вы уверены, что хотите удалить этот прием?", "Подтверждение удаления",
//                    MessageBoxButton.YesNo, MessageBoxImage.Question);

//                if (result == MessageBoxResult.Yes)
//                {
//                    try
//                    {
//                        Connection.vetclinicEntities.Appointment.Remove(selectedAppointment);
//                        Connection.vetclinicEntities.SaveChanges();
//                        appointments.Remove(selectedAppointment);
//                        dgAppointments.ItemsSource = appointments.ToList();

//                        MessageBox.Show("Прием успешно удален.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
//                    }
//                    catch (Exception ex)
//                    {
//                        MessageBox.Show($"Ошибка при удалении приема: {ex.Message}", "Ошибка",
//                            MessageBoxButton.OK, MessageBoxImage.Error);
//                    }
//                }
//            }
//            else
//            {
//                MessageBox.Show("Пожалуйста, выберите прием для удаления.", "Предупреждение",
//                    MessageBoxButton.OK, MessageBoxImage.Warning);
//            }
//        }

//        private void FilterButton_Click(object sender, RoutedEventArgs e)
//        {
//            if (dpFilterDate.SelectedDate.HasValue)
//            {
//                DateTime selectedDate = dpFilterDate.SelectedDate.Value.Date;
//                var filteredAppointments = appointments.Where(a =>
//                    a.DateAccep.HasValue && a.DateAccep.Value.Date == selectedDate).ToList();

//                dgAppointments.ItemsSource = filteredAppointments;

//                if (!filteredAppointments.Any())
//                {
//                    MessageBox.Show("На выбранную дату приемов не найдено.", "Информация",
//                        MessageBoxButton.OK, MessageBoxImage.Information);
//                }
//            }
//            else
//            {
//                MessageBox.Show("Пожалуйста, выберите дату для фильтрации.", "Предупреждение",
//                    MessageBoxButton.OK, MessageBoxImage.Warning);
//            }
//        }

//        private void ClearFilterButton_Click(object sender, RoutedEventArgs e)
//        {
//            dpFilterDate.SelectedDate = null;
//            dgAppointments.ItemsSource = appointments.ToList();
//        }


//    }
//}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using VetClinic.db;

namespace VetClinic.window
{
    public partial class WindowAppointment : Window
    {
        private List<Appointment> _appointments = new List<Appointment>();

        public WindowAppointment()
        {
            InitializeComponent();
            LoadAppointments();
        }

        private void LoadAppointments()
        {
            try
            {
                _appointments = Connection.vetclinicEntities.Appointment.ToList();
                dgAppointments.ItemsSource = _appointments;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void AddAppointment_Click(object sender, RoutedEventArgs e)
        {
            var windowAdd = new WindowAdd();
            windowAdd.DataSaved += () => LoadAppointments();
            windowAdd.ShowDialog();
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            string search = txtSearch.Text.Trim().ToLower();
            dgAppointments.ItemsSource = string.IsNullOrEmpty(search)
                ? _appointments
                : _appointments.Where(i => i.Animal.Name.ToLower().Contains(search)).ToList();
        }

        private void EditAppointment_Click(object sender, RoutedEventArgs e)
        {
            if (dgAppointments.SelectedItem is Appointment selectedAppointment)
            {
                var windowEdit = new WindowEdit(selectedAppointment);
                windowEdit.ShowDialog();
                LoadAppointments();
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите прием для редактирования", "Предупреждение",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void DeleteAppointment_Click(object sender, RoutedEventArgs e)
        {
            if (dgAppointments.SelectedItem is Appointment selectedAppointment)
            {
                var result = MessageBox.Show("Вы уверены, что хотите удалить этот прием?", "Подтверждение удаления",
                    MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    try
                    {
                        Connection.vetclinicEntities.Appointment.Remove(selectedAppointment);
                        Connection.vetclinicEntities.SaveChanges();
                        LoadAppointments();
                        MessageBox.Show("Прием успешно удален.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Ошибка при удалении приема: {ex.Message}", "Ошибка",
                            MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите прием для удаления.", "Предупреждение",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void FilterButton_Click(object sender, RoutedEventArgs e)
        {
            if (dpFilterDate.SelectedDate.HasValue)
            {
                DateTime selectedDate = dpFilterDate.SelectedDate.Value.Date;
                var filteredAppointments = _appointments.Where(a =>
                    a.DateAccep.HasValue && a.DateAccep.Value.Date == selectedDate).ToList();

                dgAppointments.ItemsSource = filteredAppointments;

                if (!filteredAppointments.Any())
                {
                    MessageBox.Show("На выбранную дату приемов не найдено.", "Информация",
                        MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите дату для фильтрации.", "Предупреждение",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void ClearFilterButton_Click(object sender, RoutedEventArgs e)
        {
            dpFilterDate.SelectedDate = null;
            dgAppointments.ItemsSource = _appointments;
        }
    }
}
