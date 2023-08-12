/*
import 'package:flow_graph/flow_graph.dart';
import 'package:flutter/material.dart';

class DagFlowPage extends StatefulWidget {
  const DagFlowPage({Key? key}) : super(key: key);

  @override
  _DagFlowPageState createState() => _DagFlowPageState();
}

class _DagFlowPageState extends State<DagFlowPage> {
  @override
  void initState() {
    super.initState();
  }

  getContainer(String title, String value) {
    return Container(
      color: const Color.fromARGB(153, 37, 196, 236),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(221, 0, 0, 0),
              fontWeight: FontWeight.w700,
              fontSize: 7,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromARGB(221, 0, 0, 0),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late GraphNode nodeRoot;
    nodeRoot = GraphNode(data: '14 PIAS', isRoot: true);

    var node1 = GraphNode(data: 'EN EJECUCION');
    var node2 = GraphNode(data: 'PIAS OPERANDO');
    var node3 = GraphNode(data: 'POR EJECUTAR');

    nodeRoot.addNext(node1);
    nodeRoot.addNext(node2);
    nodeRoot.addNext(node3);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlowGraphView(
              enabled: true,
              root: nodeRoot,
              direction: Axis.vertical,
              centerLayout: true,
              builder: (context, node) {
                String nodeTitle = node.data.toString();
                if (node.data == 'EN EJECUCION') {
                  return getContainer(nodeTitle, '1');
                }
                if (node.data == 'PIAS OPERANDO') {
                  return getContainer(nodeTitle, '5');
                }
                if (node.data == 'POR EJECUTAR') {
                  return getContainer(nodeTitle, '8');
                }
                return Container(
                  color: const Color.fromARGB(44, 37, 196, 236),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        nodeTitle,
                        style: const TextStyle(
                          color: Color.fromARGB(221, 0, 0, 0),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/