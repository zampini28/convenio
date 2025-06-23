import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalAppointmentMapView extends StatefulWidget {
  const MedicalAppointmentMapView({Key? key}) : super(key: key);

  @override
  State<MedicalAppointmentMapView> createState() => _MedicalAppointmentMapViewState();
}

class _MedicalAppointmentMapViewState extends State<MedicalAppointmentMapView> {
  final MapController mapController = MapController();
  
  // Sample medical appointment locations
  final List<MedicalAppointment> appointments = [
    MedicalAppointment(
      id: '1',
      doctorName: 'Dr. Silva',
      specialty: 'Cardiologista',
      clinicName: 'Clinica do Coração',
      address: 'Rua das Flores, 123, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 1)),
      location: LatLng(-23.522, -46.186), // Mogi das Cruzes coordinates
    ),
    MedicalAppointment(
      id: '2',
      doctorName: 'Dr. Santos',
      specialty: 'Dermatologista',
      clinicName: 'Clinica da Pele',
      address: 'Av. Voluntários da Pátria, 456, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 3)),
      location: LatLng(-23.520, -46.188),
    ),
    MedicalAppointment(
      id: '3',
      doctorName: 'Dr. Oliveira',
      specialty: 'Pediatrica',
      clinicName: 'Clinica das Crianças',
      address: 'Rua do Centro, 789, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 7)),
      location: LatLng(-23.524, -46.184),
    ),
  ];

  MedicalAppointment? selectedAppointment;

  List<Marker> _buildMarkers() {
    return appointments.map((appointment) {
      return Marker(
        point: appointment.location,
        width: 50,
        height: 50,
        child: GestureDetector(
          onTap: () => _selectAppointment(appointment),
          child: Container(
            decoration: BoxDecoration(
              color: selectedAppointment?.id == appointment.id 
                ? Colors.red[700] 
                : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }).toList();
  }

  void _selectAppointment(MedicalAppointment appointment) {
    setState(() {
      selectedAppointment = appointment;
    });
    
    // Center map on selected appointment
    mapController.move(appointment.location, 16.0);
    
    // Show appointment details
    _showAppointmentDetails(appointment);
  }

  void _showAppointmentDetails(MedicalAppointment appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_hospital, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment.clinicName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildDetailRow(Icons.person, 'Médico', appointment.doctorName),
              _buildDetailRow(Icons.medical_services, 'Especialista', appointment.specialty),
              _buildDetailRow(Icons.location_on, 'Endereço', appointment.address),
              _buildDetailRow(Icons.calendar_today, 'Data', 
                '${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}'),
              _buildDetailRow(Icons.access_time, 'Tempo', 
                '${appointment.dateTime.hour.toString().padLeft(2, '0')}:${appointment.dateTime.minute.toString().padLeft(2, '0')}'),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openInMaps(appointment),
                      icon: Icon(Icons.directions),
                      label: Text('Abrir no Mapas'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _centerOnAppointment(appointment),
                      icon: Icon(Icons.center_focus_strong),
                      label: Text('Centralizar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _openInMaps(MedicalAppointment appointment) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${appointment.location.latitude},${appointment.location.longitude}';
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Não foi possivél abrir o Mapa');
      }
    } catch (e) {
      _showSnackBar('error ao abrir o mapa: $e');
    }
  }

  void _centerOnAppointment(MedicalAppointment appointment) {
    mapController.move(appointment.location, 16.0);
    Navigator.pop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAppointmentsList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Próximos Consultas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.local_hospital, color: Colors.white, size: 20),
                        ),
                        title: Text(appointment.clinicName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${appointment.doctorName} - ${appointment.specialty}'),
                            Text(
                              '${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year} at ${appointment.dateTime.hour.toString().padLeft(2, '0')}:${appointment.dateTime.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pop(context);
                          _selectAppointment(appointment);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetMapView() {
    setState(() {
      selectedAppointment = null;
    });
    mapController.move(LatLng(-23.522, -46.186), 14.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultas Médicas'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _showAppointmentsList,
            tooltip: 'Ver lista de consultas',
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetMapView,
            tooltip: 'Resetar mapa',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Clique nos hospitais marcados para ver detales de consulta ',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                ),
              ],
            ),
          ),
          if (selectedAppointment != null)
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.red[50],
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Selecionados: ${selectedAppointment!.clinicName}',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => selectedAppointment = null),
                    child: Text('Limpar'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(-23.522, -46.186), // Mogi das Cruzes center
                initialZoom: 14.0,
                minZoom: 10.0,
                maxZoom: 18.0,
                onTap: (tapPosition, point) {
                  // Deselect appointment when tapping on empty area
                  if (selectedAppointment != null) {
                    setState(() {
                      selectedAppointment = null;
                    });
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.medical_appointment_app',
                  maxZoom: 19,
                ),
                MarkerLayer(
                  markers: _buildMarkers(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "zoom_in",
            mini: true,
            onPressed: () {
              final zoom = mapController.camera.zoom;
              mapController.move(mapController.camera.center, zoom + 1);
            },
            child: Icon(Icons.zoom_in),
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "zoom_out",
            mini: true,
            onPressed: () {
              final zoom = mapController.camera.zoom;
              mapController.move(mapController.camera.center, zoom - 1);
            },
            child: Icon(Icons.zoom_out),
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "center_map",
            onPressed: _resetMapView,
            child: Icon(Icons.center_focus_strong),
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            tooltip: 'Center Map',
          ),
        ],
      ),
    );
  }
}

class MedicalAppointment {
  final String id;
  final String doctorName;
  final String specialty;
  final String clinicName;
  final String address;
  final DateTime dateTime;
  final LatLng location;

  MedicalAppointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.clinicName,
    required this.address,
    required this.dateTime,
    required this.location,
  });
}
