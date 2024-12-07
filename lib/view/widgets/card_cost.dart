part of 'widgets.dart';

class CardCosts extends StatefulWidget {
  final Costs costs;
  const CardCosts(this.costs);

  @override
  State<CardCosts> createState() => _CardCostsState();
}

class _CardCostsState extends State<CardCosts> {
  @override
  Widget build(BuildContext context) {
    Costs costs = widget.costs;
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.white,
        elevation: 4,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 8, 8),
          title: Text(
              "${costs.description.toString()} (${costs.service.toString()})"),
          subtitle: Text("Estimasi Sampai: ${costs.cost![0].etd} hari"),
          leading: CircleAvatar(
              backgroundColor: Colors.grey, child: Icon(Icons.map_outlined)),
          trailing: Text("Biaya: Rp. ${costs.cost![0].value},-"),
        ));
  }
}
