import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalAppointmentMapView extends StatefulWidget {
  const MedicalAppointmentMapView({Key? key}) : super(key: key);

  @override
  State<MedicalAppointmentMapView> createState() => _MedicalAppointmentMapViewState();
}

class _MedicalAppointmentMapViewState extends State<MedicalAppointmentMapView> {
  GoogleMapController? mapController;
  Set<Marker> markers = <Marker>{};
  
  // Sample medical appointment locations
  final List<MedicalAppointment> appointments = [
    MedicalAppointment(
      id: '1',
      doctorName: 'Dr. Silva',
      specialty: 'Cardiologista',
      clinicName: 'Cinica do coração',
      address: 'Rua das Flores, 123, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 1)),
      location: LatLng(-23.522, -46.186), // Mogi das Cruzes coordinates
    ),
    MedicalAppointment(
      id: '2',
      doctorName: 'Dr. Santos',
      specialty: 'Dermatologista',
      clinicName: 'Clinica da pele',
      address: 'Av. Voluntários da Pátria, 456, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 3)),
      location: LatLng(-23.520, -46.188),
    ),
    MedicalAppointment(
      id: '3',
      doctorName: 'Dr. Oliveira',
      specialty: 'Pediatra',
      clinicName: 'Clinica da criança',
      address: 'Rua do Centro, 789, Mogi das Cruzes',
      dateTime: DateTime.now().add(Duration(days: 7)),
      location: LatLng(-23.524, -46.184),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    for (var appointment in appointments) {
      markers.add(
        Marker(
          markerId: MarkerId(appointment.id),
          position: appointment.location,
          infoWindow: InfoWindow(
            title: appointment.clinicName,
            snippet: '${appointment.doctorName} - ${appointment.specialty}',
            onTap: () => _showAppointmentDetails(appointment),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () => _showAppointmentDetails(appointment),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showAppointmentDetails(MedicalAppointment appointment) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_hospital, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Text(
                    appointment.clinicName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildDetailRow(Icons.person, 'Medico', appointment.doctorName),
              _buildDetailRow(Icons.medical_services, 'Especialidade', appointment.specialty),
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
                      onPressed: () => _getDirections(appointment),
                      icon: Icon(Icons.directions),
                      label: Text('Ver Direção'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                      label: Text('Fechar'),
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

  void _getDirections(MedicalAppointment appointment) {
    // Here you would typically integrate with a navigation app
    // or implement turn-by-turn directions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Carregando direção para ${appointment.clinicName}'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _goToLocation(LatLng location) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultas Medicas'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => _showAppointmentsList(),
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
                    'Clique para ver detales da consulta',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-23.522, -46.186), // Mogi das Cruzes center
                zoom: 14.0,
              ),
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToLocation(LatLng(-23.522, -46.186)),
        child: Icon(Icons.center_focus_strong),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        tooltip: 'Center Map',
      ),
    );
  }

  void _showAppointmentsList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Próximas Consultas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...appointments.map((appointment) => Card(
                child: ListTile(
                  leading: Icon(Icons.local_hospital, color: Colors.red),
                  title: Text(appointment.clinicName),
                  subtitle: Text('${appointment.doctorName} - ${appointment.specialty}'),
                  trailing: Text(
                    '${appointment.dateTime.day}/${appointment.dateTime.month}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _goToLocation(appointment.location);
                    _showAppointmentDetails(appointment);
                  },
                ),
              )).toList(),
            ],
          ),
        );
      },
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
