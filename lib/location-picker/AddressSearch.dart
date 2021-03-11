import 'package:pool_rides/models/suggestion.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ListTile(
                      title: Text(
                          (snapshot.data[index] as Suggestion).description),
                      onTap: () {
                        close(context, snapshot.data[index] as Suggestion);
                      },
                    ),
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
    );
  }
}
