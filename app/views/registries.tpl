{{template "base/base.html" .}}
{{define "body"}}
  {{template "newregistry.tpl" .}}
  <div class="right-content-container">
    <div class="header">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="/">Home</a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">Registries</li>
        </ol>
      </nav>
    </div>

    <div class="content-block-empty">
      <div class="card-deck">
        {{range $key, $registry := .registries}}
          <div class="card">
            <img class="card-img-top border-bottom bg-light" style="max-height:200px" src="http://1000logos.net/wp-content/uploads/2017/07/Docker-Logo-500x148.png" alt="Card image cap">
            <div class="card-body">
              <div class="row-fluid mb-4">
                <h4 class="card-title">{{$registry.Name}}</h4>
                <h5 class="card-subtitle mb-2 text-muted">{{$registry.IP}}</h5>
              </div>
              <div class="container">
                <div class="row">
                  <div class="col-lg-4 col-md-6 text-center border-right">
                    <div class="row-fluid no-gutters">
                      <div class="col" style="position: relative;">
                        <canvas id="{{$registry.Name}}-repositories-chart"></canvas>
                      </div>
                    </div>
                    <div class="row-fluid no-gutters">
                      <span class="metric-value">{{len $registry.Repositories}}</span>
                    </div>
                    <h8>Repositories</h8>
                  </div>
                  <div class="col-lg-4 col-md-6 text-center border-right">
                    <div class="row-fluid no-gutters">
                      <div class="col" style="position: relative;">
                        <canvas id="{{$registry.Name}}-tags-chart"></canvas>
                      </div>
                    </div>
                    <div class="row-fluid no-gutters">
                      <span class="metric-value">{{$registry.TagCount}}</span>
                    </div>
                    <h8>Tags</h8>
                  </div>
                  <div class="col-lg-4 col-md-6 text-center">
                    <div class="row-fluid no-gutters">
                      <div class="col" style="position: relative;">
                        <canvas id="{{$registry.Name}}-layers-chart"></canvas>
                      </div>
                    </div>
                    <div class="row-fluid no-gutters">
                      <span class="metric-value">{{$registry.LayerCount}}</span>
                    </div>
                    <h8>Layers</h8>
                  </div>
                </div>
                <div class="row mt-4">
                </div>
              </div>
            </div>
            <div class="card-footer">
              <div class="row d-flex align-items-center">
                <div class="col">
                  <small class="text-muted align-baseline">Last updated {{timeAgo $registry.LastRefresh}}</small>
                </div>
                <div class="col text-right">
                  <a href="#" class="btn btn-info">Edit</a>
                  <a href="/registries/{{$registry.Name}}/repositories" class="btn btn-orange">View</a>
                </div>
              </div>
            </div>
          </div>
       {{end}}
        <div class="card d-flex bg-light justify-content-center align-text-middle" style="min-height:275px">
          <div type="button" class="add-new align-self-center" data-toggle="modal" data-target="#new-registry-modal">
            <i class="fa fa-plus add-new-icon"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
  {{range $key, $registry := .registries}}
    const repos = document.getElementById('{{$registry.Name}}-repositories-chart').getContext('2d');
    const chart1 = new Chart(repos, {
      type: 'line',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
        datasets: [ { data: [4, 5, 5, 6, 3, 3, 5, 5] } ]
      },
      options: {
        responsive: true,
        legend: { display: false },
        elements: {
          line: {
            borderColor: '#000000',
            backgroundColor: '#FFF',
            borderWidth: 1
          },
          point: {
            radius: 0
          }
        },
        tooltips: {
          enabled: true
        },
        scales: {
          yAxes: [ { display: false } ],
          xAxes: [ { display: false } ]
        }
      }
    });

    const tags = document.getElementById('{{$registry.Name}}-tags-chart').getContext('2d');
    const chart2 = new Chart(tags, {
      type: 'line',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
        datasets: [ { data: [47, 50, 50, 51, 50, 53, 53, 53] } ]
      },
      options: {
        responsive: true,
        legend: { display: false },
        elements: {
          line: {
            borderColor: '#000000',
            backgroundColor: '#FFF',
            borderWidth: 1
          },
          point: {
            radius: 0
          }
        },
        tooltips: {
          enabled: true
        },
        scales: {
          yAxes: [ { display: false } ],
          xAxes: [ { display: false } ]
        }
      }
    });

    const layers = document.getElementById('{{$registry.Name}}-layers-chart').getContext('2d');
    const chart3 = new Chart(layers, {
      type: 'line',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
        datasets: [ { data: [80, 80, 80, 81, 80, 83, 83, 83] } ]
      },
      options: {
        responsive: true,
        legend: { display: false },
        elements: {
          line: {
            borderColor: '#000000',
            backgroundColor: '#FFF',
            borderWidth: 1
          },
          point: {
            radius: 0
          }
        },
        tooltips: {
          enabled: true
        },
        scales: {
          yAxes: [ { display: false } ],
          xAxes: [ { display: false } ]
        }
      }
    });
    {{end}}
  </script>
{{end}}
