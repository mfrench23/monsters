import React from "react"
import PropTypes from "prop-types"
import HiddenField from "./HiddenField.jsx"
import ManyToManyCheckbox from "./ManyToManyCheckbox.jsx"
import ManyToManyDisplayedField from "./ManyToManyDisplayedField.jsx"

class ManyToManyCell extends React.Component {
  render () {
    var rowIdValue;
    if( this.props.intersectionRowId ) {
      rowIdValue = this.props.intersectionRowId.toString();
    } else {
      rowIdValue = "";
    }
    return (
      <span>
        <HiddenField identifier={this.props.cellId + "[id]"} val={rowIdValue} />
        <HiddenField identifier={this.props.cellId + "[" + this.props.foreignKeyName + "]"} val={this.props.intersectedId} />
        <HiddenField identifier={this.props.cellId + "[_destroy]"} val="true" />
        <ManyToManyCheckbox identifier={this.props.cellId + "[_destroy]"} val="false" checked={this.props.checked} callback={this.props.callback} index={this.props.intersectedId} subheader={this.props.subheader} excluded={this.props.excluded}/>
        <ManyToManyDisplayedField title={this.props.displayTitle} text={this.props.displayText} excluded={this.props.excluded} />
      </span>
    );
  }
}

ManyToManyCell.propTypes = {
  cellId: PropTypes.string,
  intersectedId: PropTypes.string,
  foreignKeyName: PropTypes.string,
  displayTitle: PropTypes.string,
  displayText: PropTypes.string,
  subheader: PropTypes.string,
  callback: PropTypes.func,
  checked: PropTypes.bool,
  excluded: PropTypes.bool,
  intersectionRowId: PropTypes.number
};
export default ManyToManyCell
