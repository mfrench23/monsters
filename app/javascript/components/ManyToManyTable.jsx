import React from "react"
import PropTypes from "prop-types"
import ManyToManyCell from "./ManyToManyCell.jsx"

class ManyToManyTable extends React.Component {
  constructor(props) {
    super(props);
    this.selectOption = this.selectOption.bind(this);
    var isVisible = {};
    var excluded = {};
    for( var k in props.spec.item_hash) {
      isVisible[k] = (props.spec.item_hash[k]["count_of_selected"] > 0);
      for( let mem of props.spec.item_hash[k]["members"] ) {
        if(mem.checked) {
          excluded[mem.intersected_id] = props.spec.exclusion_hash[mem.intersected_id];
        }
      }
    };
    this.state = { spec: props.spec,
                    isVisible: isVisible,
                    excluded: excluded };
  }

  toggleVisible (subheader, e) {
    var iV = this.state.isVisible;
    iV[subheader] = ! iV[subheader];
    this.setState( {isVisible: iV } );
  }

  selectOption (subheader, intersectedId) {
    var s = this.state.spec;
    var excluded = this.state.excluded;
    for( let mem of s.item_hash[subheader]["members"] ) {
      if( mem["intersected_id"].toString() == intersectedId ) {
        mem.checked = ! mem.checked;
        if(mem.checked) {
          excluded[mem.intersected_id] = this.state.spec.exclusion_hash[mem.intersected_id];
        } else {
          excluded[mem.intersected_id] = [];
        }
        break;
      }
    }
    this.setState( {spec: s, excluded: excluded} );
  }

  render () {
    if( this.state.spec.total_count == 0 ) {
      return (
        <div class="footnote">none applicable</div>
      );
    }
    var flatExcluded = [];
    var excludedValues = Object.keys(this.state.excluded).map((k) => { return this.state.excluded[k]; } );
    if(excludedValues) {
      flatExcluded = Array.prototype.concat(...excludedValues);
    }
    return (
      <div className="many_to_many_table">
        <div>
          { Object.keys(this.state.spec.item_hash).map((subheader, idx) => (
            <div key={subheader}>
              <div>
                {subheader}
                &nbsp;
                <button type="button" data-subheader={subheader} onClick={this.toggleVisible.bind(this, subheader)} >{ this.state.isVisible[subheader] ? "-" : "+" }</button>
              </div>
              <ul className="grid_layout" style={ this.state.isVisible[subheader] ? null : {display: 'none'}}>
                { this.state.spec.item_hash[subheader]["members"].map((member, mIdx) => (
                  <li key={member["intersected_id"]}>
                    <ManyToManyCell
                      cellId={this.props.baseId + "[" + member["intersected_id"] + "]"}
                      intersectedId={member["intersected_id"].toString()}
                      foreignKeyName={member["foreign_key_name"]}
                      displayTitle={member["display_title"]}
                      displayText={member["display_text"]}
                      intersectionRowId={member["intersection_row_id"]}
                      excluded={flatExcluded.includes(member["intersected_id"])}
                      checked={member["checked"]}
                      callback={this.selectOption}
                      subheader={subheader}
                    />
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>
    );
  }
}

ManyToManyTable.propTypes = {
  spec: PropTypes.object,
  baseId: PropTypes.string
};
export default ManyToManyTable
